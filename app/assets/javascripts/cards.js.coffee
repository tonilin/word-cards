# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class CardFlow
  constructor: (@container)->
    @bindEvents()

  bindEvents: ->
    @container.on "click", ".card-box" , (event)=>
      @flipCard(event.currentTarget)


    $(document).keydown (event) =>
      @switchToNextCard() if event.keyCode == 40 # down
    $(document).keydown (event) =>
      @switchToPreviousCard() if event.keyCode == 38 # up
    $(document).keydown (event) =>
      @flipCardToBack() if event.keyCode == 39 # right
    $(document).keydown (event) =>
      @flipCardToFront() if event.keyCode == 37 # left



  flipCard: (cardBox)->
    $(cardBox).toggleClass("flip")

  flipCardToFront: (cardBox)->
    cardBox = @currentCard() if !cardBox

    $(cardBox).removeClass("flip")

  flipCardToBack: (cardBox)->
    cardBox = @currentCard() if !cardBox
    $(cardBox).addClass("flip")

  disableCard:  (cardBox)->
    $(cardBox).removeClass("active")

  activeCard:  (cardBox)->
    $(cardBox).addClass("active")

  currentCard: ->
    @container.find(".card-box.active").eq(0)

  nextCard: ->
    nextCard = @currentCard().next()

    if nextCard.length > 0
      return nextCard
    else
      return @container.find(".card-box").eq(0)

  previousCard: ->
    previousCard = @currentCard().prev()

    if previousCard.length > 0
      return previousCard
    else
      return @container.find(".card-box").last()

  moveCurrentCardToView: ->
    @container.find(".cards-wrapper").css("margin-top", -(@currentCard().prevAll().length * 220) + 220)

  switchToNextCard: ->
    currentCard = @currentCard()
    nextCard = @nextCard()

    @flipCardToFront(currentCard)
    @disableCard(currentCard)

    @activeCard(nextCard)

    @moveCurrentCardToView()

  switchToPreviousCard: ->
    currentCard = @currentCard()
    previousCard = @previousCard()

    @flipCardToFront(currentCard)
    @disableCard(currentCard)

    @activeCard(previousCard)

    @moveCurrentCardToView()

$ ->
  new CardFlow($(".cards-container")) if $(".cards-container").length > 0

