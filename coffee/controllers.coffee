getRandomInt = (min, max) ->
  Math.floor(Math.random() * (max - min)) + min

class TTS
  constructor: ->
    @audio = new Audio()

  play: (lang, text) ->
    @audio.pause()
    @audio.src = "http://translate.google.com/translate_tts?tl=#{lang}&q=#{text}&total=1&idx=0"
    @audio.play()

app = angular.module('numbersApp', [])

app.controller 'gameCtrl', ($scope) ->
  tts = new TTS()

  # score
  $scope.correct = 0
  $scope.total   = 0

  $scope.value = null
  $scope.correct_answer = null

  $scope.next = ->

    if $scope.value?
      if parseInt($scope.answer) == $scope.value
        $scope.correct_answer = null
        $scope.correct++
      else
        $scope.correct_answer = $scope.value
      $scope.total++
      $scope.answer = ''

    $scope.value = getRandomInt($scope.min, $scope.max)
    tts.play($scope.language, $scope.value)

  $scope.started = -> $scope.value?

app.controller 'ctrl', ($scope) ->
  $scope.LANGS = LANGS
  $scope.language = localStorage.getItem('lang') or 'en'
  $scope.min      = parseInt(localStorage.getItem('min')) or 0
  $scope.max      = parseInt(localStorage.getItem('max')) or 99999
  $scope.$watch 'language', ->
    localStorage.setItem('lang', $scope.language)
  $scope.$watch 'min', ->
    localStorage.setItem('min', $scope.min)
  $scope.$watch 'max', ->
    localStorage.setItem('max', $scope.max)

LANGS =
  'af': 'Afrikaans'
  'sq': 'Albanian'
  'ar': 'Arabic'
  'hy': 'Armenian'
  'ca': 'Catalan'
  'zh-CN': 'Mandarin (simplified)'
  'zh-TW': 'Mandarin (traditional)'
  'hr': 'Croatian'
  'cs': 'Czech'
  'da': 'Danish'
  'nl': 'Dutch'
  'en': 'English'
  'eo': 'Esperanto'
  'fi': 'Finnish'
  'fr': 'French'
  'de': 'German'
  'el': 'Greek'
  'ht': 'Haitian Creole'
  'hi': 'Hindi'
  'hu': 'Hungarian'
  'is': 'Icelandic'
  'id': 'Indonesian'
  'it': 'Italian'
  'ja': 'Japanese'
  'ko': 'Korean'
  'la': 'Latin'
  'lv': 'Latvian'
  'mk': 'Macedonian'
  'no': 'Norwegian'
  'pl': 'Polish'
  'pt': 'Portuguese'
  'ro': 'Romanian'
  'ru': 'Russian'
  'sr': 'Serbian'
  'sk': 'Slovak'
  'es': 'Spanish'
  'sw': 'Swahili'
  'sv': 'Swedish'
  'ta': 'Tamil'
  'th': 'Thai'
  'tr': 'Turkish'
  'vi': 'Vietnamese'
  'cy': 'Welsh'
