<?php

    // boards_data required
?>

<table class="table">
    <thead>
        <tr>Доска</tr> <tr>Название</tr> <tr>Описание</tr> <tr>Постов</tr>
    </thead>
    <tbody>
        <?php for ($i = 1; $i <= 10; $i++): ?>
                <th>
                <tr> <?php echo $items["short_name"]; ?></tr>
                <tr> <?php echo $items["name"]; ?> </tr>
                <tr> <?php echo $items["descriptions"]; ?></tr>
                <tr> <?php echo $items["post_counts"]; ?></tr>
                </th>
        <?php endfor; ?>
    </tbody>
</table>