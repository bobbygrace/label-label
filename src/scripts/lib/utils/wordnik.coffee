$ = require 'jquery'

module.exports = new class Wordnik
  api_key: '51a70731d2c802d5bea2788f7fa3d87d2afe982f98a6e241a'

  getRandomWords: (opts, callback) ->
    # opts expects a limit.

    limit = 1
    if opts.limit
      limit = opts.limit

    include = "noun,adjective,verb"
    exclude = "noun-plural,noun-posessive,proper-noun,proper-noun-plural,proper-noun-posessive,auxiliary-verb"

    url = "http://api.wordnik.com:80/v4/words.json/randomWords?hasDictionaryDef=true&minCorpusCount=0&includePartOfSpeech=#{include}&excludePartOfSpeech=#{exclude}&maxCorpusCount=-1&minDictionaryCount=1&maxDictionaryCount=-1&minLength=4&maxLength=-1&limit=#{limit}&api_key=#{@api_key}"

    $.get url, (data) =>
      callback(data)

    return

  getDefinition: (opts, callback) ->
    # opts expectsa a word.

    word = opts.word
    if !word
      callback "No word given."

    url = "http://api.wordnik.com:80/v4/word.json/#{encodeURIComponent(word)}/definitions?limit=200&includeRelated=true&useCanonical=true&includeTags=false&api_key=#{@api_key}"

    $.get url, (data) =>
      def = data[0]?.text
      if !def
        def = "No definition found."
      callback(def)

    return
