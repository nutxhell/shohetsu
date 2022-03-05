-- {"id":4301,"ver":"1.1.2","libVer":"1.0.0","author":"MechTechnology"}

local baseURL = "https://pinkmuffinyum.wordpress.com"

local text = function(v)
	return v:text()
end

local function shrinkURL(url)
	return url:gsub("^.-pinkmuffinyum%.wordpress%.com", "")
end

local function expandURL(url)
	return baseURL .. url
end

local function getPassage(chapterURL)
	local doc = GETDocument(expandURL(chapterURL)):selectFirst("div.wp-site-blocks")
	local chap = doc:selectFirst(".entry-content.wp-block-post-content")
	local title = doc:selectFirst("h2.wp-block-post-title"):text()
	chap:child(0):before("<h1>" .. title .. "</h1>")
	-- Removes the like button div and script
	chap:selectFirst("#jp-post-flair"):remove()
	return pageOfElem(chap, true)
end

local function parseNovel(novelURL, loadChapters)
	local doc = GETDocument(expandURL(novelURL)):selectFirst("div.wp-site-blocks")
	local content = doc:selectFirst("main.wp-block-group")

	local info = NovelInfo {
		title = doc:selectFirst("h2.wp-block-post-title"):text(),
		imageURL = content:selectFirst("img"):attr("data-orig-file"),
		description = table.concat(map(doc:selectFirst(".entry-content.wp-block-post-content"):select("p"), text), '\n'),
		artists = {
			"Translator: " .. content:selectFirst(".wp-block-post-author__name"):text(),
		}
	}

	if loadChapters then
		local chapters = (mapNotNil(content:selectFirst(".entry-content.wp-block-post-content"):select("a.wp-block-button__link"), function(v, i)
			if v:attr("href") ~= "" then
				return NovelChapter {
					order = i,
					title = v:text(),
					link = shrinkURL(v:attr("href"))
				}
			end
		end))
		info:setChapters(AsList(chapters))
	end
	
	return info
end

local function parseListing(listingURL)
	local doc = GETDocument(listingURL)
	return map(doc:select(".wp-block-image.size-full > a"), function(v)
		if v ~= nil then
			return Novel {
				title = v:parent():selectFirst("figcaption"):text(),
				link = shrinkURL(v:attr("href")),
				imageURL = v:selectFirst("img"):attr("data-orig-file")
			}
		end
	end)
end

local function getListing()
	return parseListing(expandURL("/all-projects/"))
end

return {
	id = 4301,
	name = "Pink Muffin TL",
	baseURL = baseURL,
	imageURL = "https://github.com/shosetsuorg/extensions/raw/dev/icons/PinkMuffinTL.png",
	chapterType = ChapterType.HTML,
	
	listings = { Listing("All Projects", false, getListing) },
	getPassage = getPassage,
	parseNovel = parseNovel,
	
	hasSearch = false,
	isSearchIncrementing = false,

	shrinkURL = shrinkURL,
	expandURL = expandURL
}
