<!-- $board_info $boards_data -->

<div class="board_title"> <?php echo $board_info["name"] ?> </div>

<form type="post" action="/create_post" id="form_thread_create" class="create_thread">
    <textarea name="topic_text" rows="10" cols="50"> </textarea> <br>
    <input type="hidden" name="board" text="<?php echo $board_info["name"] ?>">
    <input id="answer_token" type="hidden" name="parrent_token" value="">
    <input type="submit" value="Ответить">
</form>

<?php for ($i = 0; $i < count($posts_data); $i++): ?>
<div class="post">
    <div class="header">
        <div class="item"> <strong><?php echo $posts_data[$i]["name"] ?> </strong> </div>
        <div class="item"> <?php echo $posts_data[$i]["author"] ?> </div>
        <div class="item"> <?php echo $posts_data[$i]["create_date"] ?> </div>
        <div class="item"> №<?php echo $posts_data[$i]["id"] ?> </div>
        <div class="item"> [<a> Ответ </a>] </div>
    </div>

    <div class="text">
        <?php echo $posts_data[$i]["text"] ?>
    </div>
    <div class="ids"> <a> <?php echo $posts_data[$i]["ids"] ?> </a> </div>
</div>

<?php endfor; ?>