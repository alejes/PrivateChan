
<div class="super_header">

    <?php for ($i = 0; $i < count($boards_data); $i++): ?>
       <div class="item"><a href="/<?php echo $boards_data[$i]["board_letter"]; ?>">[/<?php echo $boards_data[$i]["board_letter"]; ?>/</a></div>]
    <?php endfor; ?>
</div>
