// 画面のスクロールに合わせてコンテンツを表示する処理
const targetIdsList = [{
        name: 'profile-terminal',
        targetIds: [
            'profile',
            'careers'
        ],
        index: 0
    },
    {
        name: 'skills-terminal',
        targetIds: [
            'language-skills',
            'framework-skills',
            'database-skills',
            'other-skills'
        ],
        index: 0
    },
    {
        name: 'works-terminal',
        targetIds: [
            'works'
        ],
        index: 0
    },
    {
        name: 'contact-terminal',
        targetIds: [
            'contact'
        ],
        index: 0
    }
];

var isAnimated = false;

$(window).on('load scroll', () => {
    if (isAnimated) {
        // アニメーション中はスルー
        return;
    }

    for (var i = 0; i < targetIdsList.length; i++) {
        var targetData = targetIdsList[i];
        var name = targetData.name;
        var targetIds = targetData.targetIds;
        var index = targetData.index;

        if (index >= targetIds.length) {
            // 表示しきっている場合はスルー
            continue;
        }

        var id = `#${targetIds[index]}`;
        var elem = $(id);
        var typedCursorElems = $(`#${name} .fade-in .profile-cursor`);

        // data属性からアニメーション名を取得
        var isAnimate = $(elem).data('animate');
        // 要素の位置を取得
        var elemOffset = $(elem).offset().top;
        // 現在のスクロールポジションを取得
        var scrollPos = $(window).scrollTop();
        // ウィンドウの高さを取得
        var wh = $(window).height();

        // 要素がウィンドウ内の1/4にきたら処理
        if (scrollPos > elemOffset - wh + (wh / 4)) {
            // 初期表示している要素を削除
            $(`#${name} .command-line.first`).remove();

            // フェードインする要素のアニメーション終了を監視する
            var fadeInElem = $(`#${name} ${id} .fade-in`);
            fadeInElem.on('animationend webkitAnimationEnd', function() {
                targetData.index++;

                if (targetData.index == targetIds.length) {
                    // 最後の描写が完了した時ナビゲーションバーにリンクを表示する
                    var navId = `#${name}`.replace('-terminal', '-menu');
                    $(navId).removeClass('disable');
                    $(navId).addClass('text-white');
                }
                // リスナー削除
                fadeInElem.off();
                isAnimated = false;
            });

            // タイピング開始
            isAnimated = true;
            $(elem).addClass(isAnimate);

            if (index - 1 >= 0) {
                // 一つ前のブロックのカーソルを非表示にする
                typedCursorElems.eq(index - 1).addClass('after');
            }
            return;
        }
    }
});


var contentsOffset = null;
$(function() {
    // リロードしたらページトップに戻す
    $('html,body').animate({ scrollTop: 0 }, '1');

    // ターミナルのサイズを計算して描写する
    for (var i = 0; i < targetIdsList.length; i++) {
        var name = targetIdsList[i].name;
        var elem = $(`#${name}`)
        var width = Math.floor(elem.outerWidth());
        var height = Math.floor(elem.outerHeight());

        $(`#${name} .size`).text(`${width}×${height}`);
    }

    // #で始まるアンカーをクリックした場合に処理
    $('a[href^="#"]').click(function() {
        if (contentsOffset === null) {
            contentsOffset = $('.contents').offset().top;
        }
        // 移動先をコンテンツ表示領域にずらすよう調整
        var adjust = contentsOffset;
        // スクロールの速度
        var speed = 400; // ミリ秒
        // アンカーの値取得
        var href = $(this).attr("href");
        // 移動先を取得
        var target = $(href == "#" || href == "" ? 'html' : href);
        // 移動先を調整
        var position = target.offset().top - adjust;
        // スムーススクロール
        $('body, html').animate({ scrollTop: position }, speed, 'swing');
        return false;
    });

    // モーダルダイアログ処理
    // $('div').click(function() {
    //     $(this).toggleClass('selected');
    // });
});


function hideWork(id) {
    console.log('id:' + id);
    // モーダルを取得
    var modal = $(`#modal-${id}`);
    modal.addClass('hidden');
}

function showWork(id) {
    // // モーダルを取得
    // var modal = $(`#modal-${id}`);
    // modal.removeClass('hidden');
}


$(document).ready(function() {
    // 改行の分「│」を追加する
    var newLineElems = $('.careers-info.not-last');
    var newLineColElems = $('.careers-info-col.not-last pre');
    for (var index = 0; index < newLineElems.length; index++) {
        var newLineElem = newLineElems.eq(index);
        var newLineColElem = newLineColElems.eq(index);

        // 行数を求める
        var numberOfLines = countNumberOfLines(newLineElem);
        var text = newLineColElem.text();
        for (var i = 0; i < numberOfLines - 1; i++) {
            text += '\n│';
        }
        newLineColElem.text(text);
    }

});

const countNumberOfLines = (elem) => {
    var text = elem.text();

    // 1行の高さ取得
    elem.text('a');
    var rowHeight = elem.height();

    var rowCount = 1;

    // 一旦空にする
    elem.text('');

    for (var i = 0; i < text.length; i++) {

        // 一文字取得して追加
        var s = text.substring(i, i + 1);
        elem.text(elem.text() + s);

        // 現在の高さ取得
        height = elem.height();

        if (height != rowHeight) {
            // 高さが変わったら行数インクリメント
            rowHeight = height;
            rowCount++;
        }

    }

    return rowCount;
}