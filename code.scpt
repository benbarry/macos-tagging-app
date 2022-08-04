property ca : current application
property tagname : {"Tag 1", "Tag 2", "Tag 3"}

use framework "Foundation"

use AppleScript version "2.4"
use scripting additions

on run {input, parameters}
	repeat with anItem in input
		add_tag(anItem, tagname)
	end repeat
	return
end run

on add_tag(theFile, atag)
	set fileURL to ca's |NSURL|'s fileURLWithPath:(POSIX path of theFile)
	set {theResult, theTags} to fileURL's getResourceValue:(reference) forKey:(ca's NSURLTagNamesKey) |error|:(missing value)
	if theTags is not missing value then
		set tagList to (theTags as list) & atag
		-- set will eliminate duplicate tag names
		set tagList to (ca's NSOrderedSet's orderedSetWithArray:tagList)'s allObjects()
		-- apply the additional tag(s) to the file/folder
		fileURL's setResourceValue:tagList forKey:(ca's NSURLTagNamesKey) |error|:(missing value)
	else
		set tagArray to ca's NSArray's arrayWithArray:atag
		set fileURL to ca's |NSURL|'s fileURLWithPath:(POSIX path of theFile)
		fileURL's setResourceValue:tagArray forKey:(ca's NSURLTagNamesKey) |error|:(missing value)
	end if
	
	return
end add_tag