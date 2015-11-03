<!-- $board_info $boards_data -->

<div class="board_title"> <?php ?> </div>

<?php for ($i = 0; $i < count($threads_data); $i++): ?>
    <div class="post">
        <div class="post_id"> <?php echo $threads_data[$i]["author"] </div>
        <div class="author"> <?php echo $threads_data[$i]["author"] ?> </div>
        <div class="text"> <?php echo $threads_data[$i]["text"] ?> </div>
        <div class="author"> <?php echo $threads_data[$i]["author"] ?> </div>
    </div>
<?php endfor; ?>