$ = require 'jquery'

module.exports = new class Wordnik
  api_key: 'a2a73e7b926c924fad7001ca3111acd55af2ffabf50eb4ae5'

  getRandomWords: (opts, callback) ->
    # opts expects a limit.

    limit = 1
    if opts.limit
      limit = opts.limit

    url = "http://api.wordnik.com:80/v4/words.json/randomWords?hasDictionaryDef=true&minCorpusCount=0&excludePartOfSpeech=noun-plural,proper-noun-plural&maxCorpusCount=-1&minDictionaryCount=1&maxDictionaryCount=-1&minLength=4&maxLength=-1&limit=#{limit}&api_key=#{@api_key}"

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
