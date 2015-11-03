<!-- $board_info $boards_data -->

<div class="board_title"> <?php echo $board_info["name"] ?> </div>
<div class="create_thread_btn"> <!--Create thread link --> </div>
<div class="">

<form action="/create_thread" id="form_thread_create" class="create_thread">
    Тема <br> <input type="text" name="topic_name">
    Текст <br> <textarea name="topic_text" rows="20" cols="50">
    </textarea>
    <input type="submit" value="Отправить">
</form>

</div>

<?php for ($i = 0; $i < count($threads_data); $i++): ?>
    <div class="post">
        <div class="post_id"> <?php echo $threads_data[$i]["id"] </div>
        <div class="author"> <?php echo $threads_data[$i]["author"] ?> </div>
        <div class="text"> <?php echo $threads_data[$i]["text"] ?> </div>
        <div class="author"> <?php echo $threads_data[$i]["author"] ?> </div>
    </div>
<?php endfor; ?>