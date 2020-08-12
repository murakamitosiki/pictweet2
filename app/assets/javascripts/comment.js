$(function(){
  function buildHTML(comment){
    var html = `<p>
                  <strong>
                    <a href=/users/${comment.user_id}>${comment.user_name}</a>
                    ：
                  </strong>
                  ${comment.text}
                </p>`//非同期通信なので更新しなくてもいいようにHTMLに差し込む要素を書いている
    return html;//
  }
  $('#new_comment').on('submit', function(e){//onの左側が何処で右側がいつ発火するのかを決めている。
    //submitがページの更新
    e.preventDefault();//デフォルトのイベントを止めている(function(e))が元々のイベント部分
    var formData = new FormData(this);
    var url = $(this).attr('action')//attrでactionの中にあるURLパターンで使用する/tweets/:tweet_id/commentsを取り出している。作ってもらうために準備をしているところ
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      //誰に作ってもらうか決める。
      dataType: 'json',
      processData: false,
      contentType: false,//トッピングニンニクなど
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.comments').append(html);
      $('.textbox').val('');
      $('.form__submit').prop('disabled', false);//連続でボタンをおす記述
    })
    .fail(function(){
      alert('error');
    })
  })
})