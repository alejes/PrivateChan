<?php

    $boards_data = []
    echo "Hello, world";

    $boards_data[$i]["topic"]

?>

<table class="table">
    <thead>
        <tr>Доска</tr> <tr>Название</tr> <tr>Описание</tr> <tr>Постов</tr>
    </thead>
    <tbody>
        <?php 
            for ($i = 1; $i <= 10; $i++) {
                echo "<th>";
                echo "<tr>" . $items["short_name"] . "</tr>";
                echo "<tr>" . $items["name"] . " </tr>";
                echo "<tr>" . $items["descriptions"] . " </tr>";
                echo "<tr>" . $items["post_counts"] . " </tr>";
                echo "</th>";
            }
        ?>
    </tbody>
</table>