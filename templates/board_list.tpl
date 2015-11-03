
<table class="table">
    <thead>
        <tr>Доска</tr> <tr>Название</tr> <tr>Описание</tr> <tr>Постов</tr>
    </thead>
    <tbody>
        <?php for ($i = 0; $i < count($boards_data); $i++): ?>
            <td>
                <tr> <?php echo $boards_data[$i]["board_letter"]; ?></tr>
                <tr> <?php echo $boards_data[$i]["board_name"]; ?> </tr>
                <tr> <?php echo $boards_data[$i]["board_info"]; ?></tr>
                <tr> <?php echo $boards_data[$i]["board_count"]; ?></tr>
            </td>
        <?php endfor; ?>
    </tbody>
</table>
