<!-- $board_info $boards_data -->

<div class="board_title"> <?php echo $board_info["name"] ?> </div>
<div class="create_thread_btn"> <a>Создать пост</a> </div>

<form action="/create_thread" id="form_thread_create" class="create_thread">
    Тема <br> <input type="text" name="topic_name"> <br>
    Текст <br> <textarea name="topic_text" rows="20" cols="50"> </textarea> <br>
    <input type="submit" value="Отправить">
</form>

<?php for ($i = 0; $i < count($threads_data); $i++): ?>
    <div class="post">
        <div class="id"> <?php echo $threads_data[$i]["id"] ?> </div>
        <div class="time"> <?php echo $threads_data[$i]["create_date"] ?> </div>
        <div class="answer"> <a> Ответ </a> </div>
        <div class="author"> <?php echo $threads_data[$i]["author"] ?> </div>
        <div class="text"> <?php echo $threads_data[$i]["text"] ?> </div>
        <div class="ids"> <?php echo $threads_data[$i]["ids"] ?> </div>
    </div>
<?php endfor; ?>