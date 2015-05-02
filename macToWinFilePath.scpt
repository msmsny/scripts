on run {input, parameters}
  set input to input as Unicode text
  set filename to replaceText(input, "/", "\\")
  set filename to replaceText(filename, "¥", "\\")
  set filename to replaceText(filename, "smb:", "")
  set filename to replaceText(filename, "cifs:", "")
  set filename to replaceText(filename, "file:", "")
  set filename to replaceText(filename, "\n", "")
  set the clipboard to do shell script "printf %s '" & filename & "' | iconv -f utf-8-mac -t utf-8"
end run

on replaceText(theText, searchStr, replaceStr)
  set tmp to AppleScript's text item delimiters
  set AppleScript's text item delimiters to searchStr
  set theList to every text item of theText
  set AppleScript's text item delimiters to replaceStr
  set theText to theList as string
  set AppleScript's text item delimiters to tmp
  return theText
end replaceText
