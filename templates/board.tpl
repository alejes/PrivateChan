<?php

    // boards_data required
?>

<table class="table">
    <thead>
        <tr>Доска</tr> <tr>Название</tr> <tr>Описание</tr> <tr>Постов</tr>
    </thead>
    <tbody>
        <?php for ($i = 0; $i < count($boards_data); $i++): ?>
            <th>
                <tr> <?php echo $boards_data[$i]["short_name"]; ?></tr>
                <tr> <?php echo $boards_data[$i]["name"]; ?> </tr>
                <tr> <?php echo $boards_data[$i]["descriptions"]; ?></tr>
                <tr> <?php echo $boards_data[$i]["post_counts"]; ?></tr>
            </th>
        <?php endfor; ?>
    </tbody>
</table>