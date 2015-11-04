<!-- $board_info $boards_data -->


<h1 class="text-center"> <?php echo $board_info["name"] ?> </h1>

<div id="form_post_create">
    <h3 class="text-center">
        [ <a onclick="hide('form_post_create')">Не создавать</a> ]
    </h3>

    <div class="row">
        <div class="col-xs-6 col-md-4"></div>
        <div class="col-xs-6 col-md-4">
			<form enctype="multipart/form-data" action="/<?php echo $board_info["board_letter"] ?>/<?php echo $thread_id; ?>/createPost" method="POST" class="form-horizontal">
                <label>Автор</label> <br> <input class="form-control" type="text" name="topic_author" value="Анон"> <br>
                <label>Текст</label> <br> <textarea class="form-control" name="topic_text" rows="10"> </textarea> <br>
                Картинка <input type="file" name="image_file"> <br>
                Видосик <input type="file" name="video_file"> <br>
                <input type="hidden" name="board" value="<?php echo $board_info["board_letter"] ?>">
                <input id="answer_token" type="hidden" name="parrent_token" value="">
                <input class="btn btn-default" type="submit" value="Ответить">
            </form>
        </div>
        <div class="col-xs-6 col-md-4"></div>
    </div>
</div>

<script>
    hide("form_post_create");

    function answer(id) {
        document.getElementById("answer_token").value = id;
        show("form_post_create");
    }

    $(document).ready(function() {
        $("a.single_image").fancybox();
    });
</script>

<?php for ($i = 0; $i < count($posts_data); $i++): ?>
<div style="margin-left:<?php 50 * $posts_data[$i]["depth"] ?>px;" class="post">
    <div class="header">
        <div class="item"> <strong><?php echo $posts_data[$i]["name"] ?> </strong> </div>
        <div class="item"> <?php echo $posts_data[$i]["author"] ?> </div>
        <div class="item"> <?php echo $posts_data[$i]["create_date"] ?> </div>
        <div class="item"> №<?php echo $posts_data[$i]["id"] ?> </div>
        <div class="item"> [<a onclick="answer('<?php echo $posts_data[$i]["id"] ?>')"> Ответ </a>] </div>
    </div>

    <?php if (isset($posts_data[$i]["image_url"])): ?>
        <a class="single_image" href="/<?php echo $posts_data[$i]["image_url"]; ?>">
            <img class="image" src="/<?php echo $posts_data[$i]["image_url"]; ?>" alt=""/>
        </a>
    <?php endif; ?>

    <?php if (isset($posts_data[$i]["video_url"])): ?>
    <div>
        <video class="vidos text-center" id="html5video" name="media" loop="1" controls>
            <source class="video" height="100%" width="100%" type="video/webm" src="/<?php echo $posts_data[$i]["video_url"]; ?>">
        </video>
    </div>
    <?php endif; ?>

    <div class="text">
        <?php echo $posts_data[$i]["text"] ?>
    </div>
    <div class="ids">
        <?php for ($i = 0; $i < count($posts_data[$i]["ids"]); $i++): ?>
            [<a href="#<?php echo $posts_data[$i]["ids"][$i] ?>"><?php echo $posts_data[$i]["ids"][$i] ?></a>]
        <?php endfor; ?>
    </div>
</div>

<?php endfor; ?>