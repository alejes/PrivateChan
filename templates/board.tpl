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
        <div class="header">
            <div class="item"><strong>Вопрос-ответ тред</strong></div>
            <div class="item"><?php echo $threads_data[$i]["author"] ?></div>
            <div class="item"> <?php echo $threads_data[$i]["create_date"] ?> </div>
            <div class="item"> №<?php echo $threads_data[$i]["id"] ?> </div>
            <div class="item"> [<a> Ответ </a>] </div>
        </div>

        <div class="text">
            <?php echo $threads_data[$i]["text"] ?>
        </div>
        <div class="ids"> <a> <?php echo $threads_data[$i]["ids"] ?> </a> </div>
    </div>
<?php endfor; ?>