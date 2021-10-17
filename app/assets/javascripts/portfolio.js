// 画面のスクロールに合わせてコンテンツを表示する処理
const targetIdList = [
    'profile',
    'language-skills',
    'framework-skills'
];
var index = 0;

$(window).on('load scroll', () => {
    if (index >= targetIdList.length) {
        return;
    }

    var id = '#' + targetIdList[index];
    var elem = $(id);
    var typedCursorElems = $('.typed .fade-in .profile-cursor');

    // data属性からアニメーション名を取得
    var isAnimate = $(elem).data('animate');
    // 要素の位置を取得
    var elemOffset = $(elem).offset().top;
    // 現在のスクロールポジションを取得
    var scrollPos = $(window).scrollTop();
    // ウィンドウの高さを取得
    var wh = $(window).height();

    // 要素がウィンドウ内の中央位置にきたら処理
    if (scrollPos > elemOffset - wh + (wh / 2)) {
        $(elem).addClass(isAnimate);

        if (index - 1 >= 0) {
            typedCursorElems.eq(index - 1).addClass('after');
        }

        index++;
    }
});


// リロードしたらページトップに戻す
$(function() {
    $('html,body').animate({ scrollTop: 0 }, '1');
});