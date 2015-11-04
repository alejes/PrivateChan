
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
            <form enctype="multipart/form-data" action="/<?php echo $board_info["board_letter"] ?>/createThread" method="POST" class="form-horizontal">
                <label>Тема</label> <br> <input class="form-control" type="text" name="topic_name"> <br>
                <label>Автор</label> <br> <input class="form-control" type="text" name="topic_author" value="Анон"> <br>
                <label>Текст</label> <br> <textarea class="form-control" name="topic_text" rows="10"> </textarea> <br>
                Картинка <input type="file" name="image_file"> <br>
                Видосик <input type="file" name="video_file"> <br>
                <input type="hidden" name="board" value="<?php echo $board_info["board_letter"] ?>">
                <input type="submit" class="btn btn-default" value="Отправить">
            </form>
        </div>
        <div class="col-xs-6 col-md-4"></div>
    </div>
</div>

<script>
    hide("form_thread_create");

    $(document).ready(function() {
        $("a.single_image").fancybox();
    });
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

        <?php if (isset($threads_data[$i]["image_url"])): ?>
            <a class="single_image" href="<?php echo $threads_data[$i]["image_url"]; ?>">
                <img class="image" src="<?php echo $threads_data[$i]["image_url"]; ?>" alt=""/>
            </a>
        <?php endif; ?>

        <?php if (isset($threads_data[$i]["video_url"])): ?>
            <div>
                <video class="vidos text-center" id="html5video" name="media" loop="1" controls>
                    <source class="video" height="100%" width="100%" type="video/webm" src="<?php echo $threads_data[$i]["video_url"]; ?>">
                </video>
            </div>
        <?php endif; ?>

        <div class="text">
            <?php echo $threads_data[$i]["text"]; ?>
        </div>
        <div class="ids"> <a> <?php echo $threads_data[$i]["ids"] ?> </a> </div>
    </div>
<?php endfor; ?>