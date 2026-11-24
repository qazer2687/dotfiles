#include <hyprland/src/plugins/PluginAPI.hpp>
#include <hyprland/src/plugins/PluginSystem.hpp>
#include <hyprland/src/Compositor.hpp>
#include <hyprland/src/render/Renderer.hpp>
#include <hyprland/src/render/pass/SurfacePassElement.hpp>
#include <hyprland/src/render/pass/RendererHintsPassElement.hpp>
#include <hyprland/src/render/types.hpp>
#include <hyprland/src/state/WorkspaceState.hpp>
#include <hyprland/src/state/MonitorState.hpp>
#include <hyprland/src/desktop/state/WindowState.hpp>
#include <hyprland/src/managers/input/InputManager.hpp>
#include <hyprland/src/event/EventBus.hpp>
#include <hyprland/src/helpers/time/Time.hpp>
#include <hyprutils/memory/SharedPtr.hpp>
#include <hyprutils/utils/ScopeGuard.hpp>
#include <algorithm>
#include <any>
#include <cmath>
#include <tuple>
#include <vector>

using namespace Desktop::View;

namespace {
constexpr double THUMB_HEIGHT = 180.0;
constexpr double THUMB_GAP = 12.0;
constexpr double EDGE_PADDING = 32.0;

HANDLE pHandle = nullptr;
CHyprSignalListener renderHook;
uint64_t ownerID = 0;
bool active = false;

void renderWindowStub(PHLWINDOW pWindow, PHLMONITOR pMonitor, CBox rectOverride, CBox clipBox, const Time::steady_tp& time) {
  if (!pWindow || !pMonitor || !pWindow->m_isMapped || !pWindow->wlSurface() || !pWindow->wlSurface()->resource())
    return;

  const auto realPosition = pWindow->position(Desktop::View::IGeometric::GEOMETRIC_CURRENT);
  const auto size = pWindow->size(Desktop::View::IGeometric::GEOMETRIC_CURRENT);
  const float logicalWidth = std::max(static_cast<float>(size.x), 5.F);
  const float scaleMod = rectOverride.w / std::max(logicalWidth * pMonitor->m_scale, 5.F);
  if (!(scaleMod > 0.F) || !(rectOverride.w > 0 && rectOverride.h > 0))
    return;

  const Vector2D logicalTopLeft = realPosition + pWindow->m_floatingOffset;
  const Vector2D scaledTopLeft = (logicalTopLeft - pMonitor->m_position) * pMonitor->m_scale;
  const Vector2D translate = rectOverride.pos() / scaleMod - scaledTopLeft;

  Render::SRenderModifData renderModif;
  renderModif.modifs.push_back(std::make_pair(Render::SRenderModifData::eRenderModifType::RMOD_TYPE_TRANSLATE, std::any(translate)));
  renderModif.modifs.push_back(std::make_pair(Render::SRenderModifData::eRenderModifType::RMOD_TYPE_SCALE, std::any(scaleMod)));
  renderModif.enabled = true;

  g_pHyprRenderer->m_renderPass.add(makeUnique<CRendererHintsPassElement>(CRendererHintsPassElement::SData{.renderModif = renderModif}));
  Hyprutils::Utils::CScopeGuard reset([] {
    g_pHyprRenderer->m_renderPass.add(makeUnique<CRendererHintsPassElement>(CRendererHintsPassElement::SData{.renderModif = Render::SRenderModifData{}}));
  });

  g_pHyprRenderer->damageWindow(pWindow);

  CSurfacePassElement::SRenderData renderdata = {pMonitor, time};
  renderdata.pos = realPosition + pWindow->m_floatingOffset;
  renderdata.w = std::max(size.x, 5.0);
  renderdata.h = std::max(size.y, 5.0);
  renderdata.fadeAlpha = 1.F;
  renderdata.alpha = 0.999F;
  renderdata.decorate = false;
  renderdata.rounding = 0;
  renderdata.roundingPower = 2.0F;
  renderdata.blur = false;
  renderdata.pWindow = pWindow;
  renderdata.clipBox = clipBox;
  renderdata.useNearestNeighbor = false;
  renderdata.squishOversized = true;
  renderdata.surfaceCounter = 0;

  pWindow->wlSurface()->resource()->breadthfirst(
      [&renderdata, &pWindow](SP<CWLSurfaceResource> surface, const Vector2D& offset, void*) {
        if (!surface || !surface->m_current.texture)
          return;
        if (surface->m_current.size.x < 1 || surface->m_current.size.y < 1)
          return;
        renderdata.localPos = offset;
        renderdata.texture = surface->m_current.texture;
        renderdata.surface = surface;
        renderdata.mainSurface = surface == pWindow->wlSurface()->resource();
        g_pHyprRenderer->m_renderPass.add(makeUnique<CSurfacePassElement>(renderdata));
        renderdata.surfaceCounter++;
      },
      nullptr);
}

void renderLayerStub(PHLLS pLayer, PHLMONITOR pMonitor, CBox rectOverride, CBox clipBox, const Time::steady_tp& time) {
  if (!pLayer || !pMonitor || !pLayer->m_mapped || !pLayer->m_layerSurface || !pLayer->wlSurface() || !pLayer->wlSurface()->resource())
    return;

  const auto realPosition = pLayer->position(Desktop::View::IGeometric::GEOMETRIC_CURRENT);
  const auto size = pLayer->size(Desktop::View::IGeometric::GEOMETRIC_CURRENT);
  const float curScaling = rectOverride.w / size.x;
  if (!(curScaling > 0.F) || !(rectOverride.w > 0 && rectOverride.h > 0))
    return;

  Render::SRenderModifData renderModif;
  renderModif.modifs.push_back(std::make_pair(Render::SRenderModifData::eRenderModifType::RMOD_TYPE_TRANSLATE, std::any(pMonitor->m_position + (rectOverride.pos() / curScaling) - realPosition)));
  renderModif.modifs.push_back(std::make_pair(Render::SRenderModifData::eRenderModifType::RMOD_TYPE_SCALE, std::any(curScaling)));
  renderModif.enabled = true;

  g_pHyprRenderer->m_renderPass.add(makeUnique<CRendererHintsPassElement>(CRendererHintsPassElement::SData{.renderModif = renderModif}));
  Hyprutils::Utils::CScopeGuard reset([] {
    g_pHyprRenderer->m_renderPass.add(makeUnique<CRendererHintsPassElement>(CRendererHintsPassElement::SData{.renderModif = Render::SRenderModifData{}}));
  });

  CSurfacePassElement::SRenderData renderdata = {pMonitor, time, realPosition};
  renderdata.fadeAlpha = 1.F;
  renderdata.alpha = 0.999F;
  renderdata.blur = false;
  renderdata.surface = pLayer->wlSurface()->resource();
  renderdata.decorate = false;
  renderdata.w = size.x;
  renderdata.h = size.y;
  renderdata.pLS = pLayer;
  renderdata.clipBox = clipBox;
  renderdata.surfaceCounter = 0;

  pLayer->wlSurface()->resource()->breadthfirst(
      [&renderdata, &pLayer](SP<CWLSurfaceResource> surface, const Vector2D& offset, void*) {
        if (!surface || !surface->m_current.texture)
          return;
        if (surface->m_current.size.x < 1 || surface->m_current.size.y < 1)
          return;
        renderdata.localPos = offset;
        renderdata.texture = surface->m_current.texture;
        renderdata.surface = surface;
        renderdata.mainSurface = surface == pLayer->wlSurface()->resource();
        g_pHyprRenderer->m_renderPass.add(makeUnique<CSurfacePassElement>(renderdata));
        renderdata.surfaceCounter++;
      },
      &renderdata);
}

bool hasWindow(PHLWORKSPACE workspace) {
  for (const auto& window : Desktop::windowState()->windows()) {
    if (!window || window->m_workspace != workspace || !window->m_isMapped || window->m_pinned)
      continue;
    if (!window->wlSurface() || !window->wlSurface()->resource())
      continue;
    return true;
  }
  return false;
}

void renderWindows(PHLWORKSPACE workspace, PHLMONITOR monitor, CBox box, double factor, const Time::steady_tp& time) {
  for (int pass = 0; pass < 3; pass++) {
    for (const auto& window : Desktop::windowState()->windows()) {
      if (!window || window->m_workspace != workspace || !window->m_isMapped || window->m_pinned || !window->wlSurface() || !window->wlSurface()->resource())
        continue;

      if (pass == 0 && window->m_isFloating)
        continue;
      if (pass == 1 && (!window->m_isFloating || workspace->getLastFocusedWindow() == window))
        continue;
      if (pass == 2 && (!window->m_isFloating || workspace->getLastFocusedWindow() != window))
        continue;

      const auto position = window->position(Desktop::View::IGeometric::GEOMETRIC_CURRENT);
      const auto size = window->size(Desktop::View::IGeometric::GEOMETRIC_CURRENT);
      const double x = box.x + (position.x - monitor->m_position.x + window->m_floatingOffset.x) * factor;
      const double y = box.y + (position.y - monitor->m_position.y + window->m_floatingOffset.y) * factor;
      const double width = size.x * factor;
      const double height = size.y * factor;
      if (!(width > 0 && height > 0))
        continue;
      renderWindowStub(window, monitor, {x, y, width, height}, box, time);
    }
  }
}

void draw() {
  const auto monitor = State::monitorState()->query().id(ownerID).run();
  if (!monitor)
    return;

  std::vector<PHLWORKSPACE> workspaces;
  for (const auto& workspace : State::workspaceState()->workspaces()) {
    if (!workspace || workspace->m_monitor != monitor || workspace->m_id < 1 || workspace->m_isSpecialWorkspace)
      continue;
    const auto locked = workspace.lock();
    if (hasWindow(locked))
      workspaces.push_back(locked);
  }

  if (workspaces.empty())
    return;

  std::sort(workspaces.begin(), workspaces.end(), [](const auto& a, const auto& b) {
    return a->m_id < b->m_id;
  });

  const CBox monitorClip = {{0, 0}, monitor->m_transformedSize};
  g_pHyprRenderer->m_renderData.clipBox = monitorClip;

  const double scale = monitor->m_scale;
  const double monitorWidth = monitor->m_size.x;
  const double monitorHeight = monitor->m_size.y;
  const double aspect = monitorWidth / std::max(monitorHeight, 1.0);
  const double gap = THUMB_GAP;
  const double padding = EDGE_PADDING;
  const double count = static_cast<double>(workspaces.size());
  const double availableWidth = std::max(monitorWidth - 2.0 * padding, 1.0);
  const double fittedHeight = (availableWidth - gap * (count - 1.0)) / (count * aspect);
  const double thumbHeight = std::min(THUMB_HEIGHT, fittedHeight);
  const double thumbWidth = thumbHeight * aspect;
  const double groupWidth = count * thumbWidth + gap * (count - 1.0);
  double startX = (monitorWidth - groupWidth) / 2.0;
  const double startY = (monitorHeight - thumbHeight) / 2.0;
  const double factor = thumbHeight / monitorHeight;
  const auto time = Time::steadyNow();

  for (const auto& workspace : workspaces) {
    const CBox box = {startX * scale, startY * scale, thumbWidth * scale, thumbHeight * scale};

    for (int layer = 0; layer < 2; layer++) {
      for (const auto& surface : monitor->m_layerSurfaceLayers[layer]) {
        if (!surface)
          continue;
        const auto position = surface->position(Desktop::View::IGeometric::GEOMETRIC_CURRENT);
        const auto size = surface->size(Desktop::View::IGeometric::GEOMETRIC_CURRENT);
        const CBox layerBox = {
          box.pos() + Vector2D((position.x - monitor->m_position.x) * factor, (position.y - monitor->m_position.y) * factor),
          size * factor,
        };
        renderLayerStub(surface.lock(), monitor, layerBox, box, time);
      }
    }

    renderWindows(workspace, monitor, box, factor, time);
    startX += thumbWidth + gap;
  }

  g_pHyprRenderer->m_renderData.clipBox = monitorClip;
  g_pHyprRenderer->damageMonitor(monitor);
}

SDispatchResult peekOpen(std::string) {
  const auto monitor = State::monitorState()->query().vec(g_pInputManager->getMouseCoordsInternal()).run();
  if (!monitor)
    return {};

  ownerID = monitor->m_id;
  active = true;
  g_pHyprRenderer->damageMonitor(monitor);
  monitor->scheduleFrame();
  return {};
}

SDispatchResult peekClose(std::string) {
  if (!active)
    return {};

  const auto monitor = State::monitorState()->query().id(ownerID).run();
  active = false;
  if (monitor) {
    g_pHyprRenderer->damageMonitor(monitor);
    monitor->scheduleFrame();
  }
  return {};
}

void onRender(eRenderStage stage) {
  if (!active || stage != eRenderStage::RENDER_LAST_MOMENT)
    return;
  if (g_pHyprRenderer->m_renderData.pMonitor != State::monitorState()->query().id(ownerID).run())
    return;
  draw();
}
}

APICALL EXPORT std::string PLUGIN_API_VERSION() {
  return HYPRLAND_API_VERSION;
}

APICALL EXPORT PLUGIN_DESCRIPTION_INFO PLUGIN_INIT(HANDLE handle) {
  pHandle = handle;
  HyprlandAPI::addDispatcherV2(pHandle, "peek:open", peekOpen);
  HyprlandAPI::addDispatcherV2(pHandle, "peek:close", peekClose);
  renderHook = Event::bus()->m_events.render.stage.listen([](eRenderStage stage) {
    onRender(stage);
  });
  return {"peek", "Hold-to-show workspace thumbnails", "local", "0.1"};
}

APICALL EXPORT void PLUGIN_EXIT() {
  renderHook.reset();
  active = false;
  pHandle = nullptr;
}
