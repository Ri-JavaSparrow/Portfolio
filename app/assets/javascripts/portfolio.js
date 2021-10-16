typedElemList = [];

$(window).on('load scroll', () => {
    // animatedのclassを持った要素をセレクタに指定
    var elems = $('.animated');
    var typedCursorElems = $('.animated.typed .fade-in .profile-cursor');

    for (var index = 0; index < elems.length; index++) {
        var elem = elems[index];
        if (!typedElemList.includes(elem.id)) {
            // data属性からアニメーション名を取得
            var isAnimate = $(elem).data('animate');
            // animated要素に位置を取得
            var elemOffset = $(elem).offset().top;
            // 現在のスクロールポジションを取得
            var scrollPos = $(window).scrollTop();
            // ウィンドウの高さを取得
            var wh = $(window).height();

            // animated要素がウィンドウ内の中央位置にきたら処理
            if (scrollPos > elemOffset - wh + (wh / 2)) {
                $(elem).addClass(isAnimate);
                typedElemList.push(elem.id);

                typedCursorElems.eq(index - 1).addClass('after');
            }
        }
    }
});
