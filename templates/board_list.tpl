
<h1 class="text-center">AUChan</h1>
<h3 class="text-center">Добро пожаловать</h3>

<table class="table table-striped">
    <thead>
        <td> <strong>Доска</strong> </td>
        <td> <strong>Название</strong> </td>
        <td> <strong>Описание</strong> </td>
        <td> <strong>Постов</strong> </td>
    </thead>
    <tbody>
        <?php for ($i = 0; $i < count($boards_data); $i++): ?>
            <tr>
                <td> <a href="/<?php echo $boards_data[$i]["board_letter"]; ?>">
                     /<?php echo $boards_data[$i]["board_letter"]; ?>/</a>
                </td>

                <td> <?php echo $boards_data[$i]["board_name"]; ?> </td>
                <td> <?php echo $boards_data[$i]["board_info"]; ?> </td>
                <td> <?php echo $boards_data[$i]["board_count"]; ?> </td>
            </tr>
        <?php endfor; ?>
    </tbody>
</table>
