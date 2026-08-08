-- styles/zsf_filter.lua
-- LuaLaTeX-Filter zur automatischen Verhinderung schlechter Umbrüche
-- in Fliesstexten (Doppelpunkte, Einheiten, kurze Gleichungen).

local in_verbatim = false
local blacklist_envs = {
  ["lstlisting"] = true,
  ["verbatim"] = true,
  ["codebox"] = true,
  ["tikzpicture"] = true,
  ["theindex"] = true,
  ["axis"] = true,
}

local function zsf_filter(line)
  -- 1. Dateinamenschutz: Nur main.tex und chapters/ verarbeiten
  local filename = status.filename
  if not filename then
    return line
  end

  local is_target = filename:find("chapters/", 1, true) or filename:find("main.tex", 1, true)
  if not is_target then
    return line
  end

  -- 2. Kommentarzeilen ignorieren
  if line:find("^%s*%%") then
    return line
  end

  -- 3. Verbatim-Zustand tracken (Plain-Search um Magic Chars wie {} zu umgehen)
  for env, _ in pairs(blacklist_envs) do
    if line:find("\\begin{" .. env .. "}", 1, true) then
      in_verbatim = true
      return line
    elseif line:find("\\end{" .. env .. "}", 1, true) then
      in_verbatim = false
      return line
    end
  end

  if in_verbatim then
    return line
  end

  -- Platzhalter zum Schutz von Escapes
  local placeholder_pct = "\001"
  local placeholder_escaped_dollar = "\002"
  local placeholder_double_dollar = "\003"

  -- Sonderzeichen schützen
  line = line:gsub("\\%%", placeholder_pct)
  line = line:gsub("\\%$", placeholder_escaped_dollar)
  line = line:gsub("%$%$", placeholder_double_dollar)

  -- 4. Keine Umbrüche in kurzen Inline-Gleichungen (f(x) = y)
  -- Länge unter 25 Zeichen und enthält Relationszeichen
  line = line:gsub("%$([^%$]+)%$", function(content)
    if #content < 25 and (content:find("=") or content:find("<") or content:find(">") or content:find("\\le") or content:find("\\ge") or content:find("\\approx") or content:find("\\neq") or content:find("\\equiv")) then
      return "${" .. content .. "}$"
    else
      return "$" .. content .. "$"
    end
  end)

  -- 5. Keine Umbrüche nach Doppelpunkt (x: Erklärung)
  line = line:gsub(":%s+", ":~")

  -- 6. Keine Umbrüche zwischen Zahlen und Einheiten (10 m/s, 95 %, 20 °C)
  -- Findet Ziffern gefolgt von Leerzeichen und einem Einheiten-Anfang
  line = line:gsub("(%d+)%s+([a-zA-Z°%%][a-zA-Z0-9%%%-/%%^%%*]*)", "%1~%2")

  -- Platzhalter wiederherstellen
  line = line:gsub(placeholder_double_dollar, "$$")
  line = line:gsub(placeholder_escaped_dollar, "\\$")
  line = line:gsub(placeholder_pct, "\\%")

  return line
end

-- Globale Registrierungs-Zustände
zsf_filter_active = false

function zsf_register_filter()
  if not zsf_filter_active then
    luatexbase.add_to_callback("process_input_buffer", zsf_filter, "zsf_filter")
    zsf_filter_active = true
  end
end

function zsf_unregister_filter()
  if zsf_filter_active then
    luatexbase.remove_from_callback("process_input_buffer", "zsf_filter")
    zsf_filter_active = false
  end
end
