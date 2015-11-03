<?php

    // boards_data required
?>

<table class="table">
    <thead>
        <tr>Доска</tr> <tr>Название</tr> <tr>Описание</tr> <tr>Постов</tr>
    </thead>
    <tbody>
<<<<<<< HEAD
        <?php for ($i = 1; $i <= 10; $i++): ?>
                <th>
                <tr> <?php echo $items["short_name"]; ?></tr>
                <tr> <?php echo $items["name"]; ?> </tr>
                <tr> <?php echo $items["descriptions"]; ?></tr>
                <tr> <?php echo $items["post_counts"]; ?></tr>
                </th>
        <?php endfor; ?>
=======
        <?php 
            for ($i = 0; $i < count($boards_data); ++$i)
            {
                echo "<th>";
                    echo "<tr>" . $items["short_name"] . "</tr>";
                    echo "<tr>" . $items["name"] . " </tr>";
                    echo "<tr>" . $items["descriptions"] . " </tr>";
                    echo "<tr>" . $items["post_counts"] . " </tr>";
                echo "</th>";
            }
        ?>
>>>>>>> 974a965416b2f62a7667e77924aff085ac88c361
    </tbody>
</table>