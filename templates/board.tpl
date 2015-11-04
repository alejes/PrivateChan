
<h1 class="text-center"> <?php echo $board_info["name"] ?> </h1>

<h3 id="create_thread" class="text-center">
    [ <a onclick="show_hide('form_thread_create', 'create_thread')">Создать тред</a> ]
</h3>

<div id="form_thread_create">
    <h3 id="create_cancel_cancel" class="text-center">
        [ <a onclick="show_hide('create_thread', 'form_thread_create')">Не создавать</a> ]
    </h3>
    <div class="row">
        <div class="col-xs-6 col-md-4"></div>
        <div class="col-xs-6 col-md-4">
            <form action="/<?php echo $board_info["board_letter"] ?>/createThread" method="POST" class="form-horizontal">
                Тема <br> <input class="form-control" type="text" name="topic_name"> <br>
                Автор <br> <input class="form-control" type="text" name="topic_author"> <br>
                Текст <br> <textarea class="form-control" name="topic_text" rows="10"> </textarea> <br>
                <input type="hidden" name="board" value="<?php echo $board_info["board_letter"] ?>">
                <input type="submit" class="btn btn-default" value="Отправить">
            </form>
        </div>
        <div class="col-xs-6 col-md-4"></div>
    </div>
</div>

<script>
    hide("form_thread_create");
</script>

<?php for ($i = 0; $i < count($threads_data); $i++): ?>
    <div id="<?php echo $threads_data[$i]["id"] ?>"class="post">
        <div class="header">
            <div class="item"> <strong><?php echo $threads_data[$i]["name"] ?></strong> </div>
            <div class="item"> <?php echo $threads_data[$i]["author"] ?> </div>
            <div class="item"> <?php echo $threads_data[$i]["create_date"] ?> </div>
            <div class="item"> №<?php echo $threads_data[$i]["id"] ?> </div>
            <div class="item"> [<a href="/<?php echo $board_info["name"] ?>/ <?php echo $threads_data[$i]["id"] ?>">
                Перейти </a>] </div>
        </div>

        <div class="text">
            <?php echo $threads_data[$i]["text"] ?>
        </div>
        <div class="ids"> <a> <?php echo $threads_data[$i]["ids"] ?> </a> </div>
    </div>
<?php endfor; ?>