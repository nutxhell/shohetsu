-- {"id":8982,"ver":"2.1.0","libVer":"1.0.0","author":"nutxhell","dep":["Madara>=2.2.0"]}

return Require("Madara")("https://euphoria-airlines.com/", {
    id = 8982,
    name = "Euphoria-Airlines"
    imageURL = "https://github.com/shosetsuorg/extensions/raw/dev/icons/euphoria-airlines.png",

    -- defaults values
    novelListingURLPath = "novellist",
    shrinkURLNovel = "series",
    searchHasOper = true,

    genres = {
        "Action",
        "Adult",
        "Adventure",
        "Comedy",
        "Dark",
        "Drama",
        "Fantasy",
        "Harem",
        "Historical",
        "Horror",
        "Isekai",
        "Josei",
        "Light Novel",
        "Manhua",
        "Manhwa",
        "Martial Arts",
        "Mature",
        "Mystery",
        "Psychological",
        "Romance",
        "School Life",
        "Seinen",
        "Shoujo",
        "Shounen",
        "Supernatural",
        "Thriller",
        "Tragedy",
        "Virtual Reality",
        "Xuanhuan",
        "Canceled",
        "On Hold",
        ["on-going"] = "Ongoing",
        ["complete"] = "Completed",
        ["slice-of-life"] = "Slice of Life",
    }
})
