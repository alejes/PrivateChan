
<table class="table table-bordered">
    <thead>
        <td>Доска</td> <td>Название</td> <td>Описание</td> <td>Постов</td>
    </thead>
    <tbody>
        <?php for ($i = 0; $i < count($boards_data); $i++): ?>
            <tr>
                <td> <?php echo $boards_data[$i]["board_letter"]; ?> </td>
                <td> <?php echo $boards_data[$i]["board_name"]; ?> </td>
                <td> <?php echo $boards_data[$i]["board_info"]; ?> </td>
                <td> <?php echo $boards_data[$i]["board_count"]; ?> </td>
            </tr>
        <?php endfor; ?>
    </tbody>
</table>
