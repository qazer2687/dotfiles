import GLib from "gi://GLib?version=2.0";

export const cache_file = `${GLib.get_user_cache_dir()}/jbar/options.json`;
export const tmp_dir = `${GLib.get_tmp_dir()}/tmp`;
export const config_dir = `${GLib.get_home_dir()}/.config/jbar`;
export const opt_file = `${config_dir}/config.json`;
export const user = GLib.get_user_name();

Utils.ensureDirectory(tmp_dir);
Utils.ensureDirectory(config_dir);
Utils.ensureDirectory(cache_file.split("/").slice(0, -1).join("/"))
