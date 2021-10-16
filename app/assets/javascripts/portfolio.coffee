# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

typedElemList = []

typing = ->
    # animatedのclassを持った要素をセレクタに指定
    elems = $('.animated')
    typedCursorElems = $('.animated.typed .fade-in .profile-cursor')

    for elem, index in elems
        if elem.id not in typedElemList

            # data属性からアニメーション名を取得
            isAnimate = $(elem).data('animate')
            # animated要素に位置を取得
            elemOffset = $(elem).offset().top
            # 現在のスクロールポジションを取得
            scrollPos = $(window).scrollTop()
            # ウィンドウの高さを取得
            wh = $(window).height()

            # animated要素がウィンドウ内の中央位置にきたら処理
            if scrollPos > elemOffset - wh + (wh / 2)
                $(elem).addClass(isAnimate)
                typedElemList.push(elem.id)

                typedCursorElems.eq(index - 1).addClass('after')

$ ->
    $(window).on('load scroll', typing)
