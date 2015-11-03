<?php

    // boards_data required
?>

<table class="table">
    <thead>
        <tr>Доска</tr> <tr>Название</tr> <tr>Описание</tr> <tr>Постов</tr>
    </thead>
    <tbody>
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
    </tbody>
</table>