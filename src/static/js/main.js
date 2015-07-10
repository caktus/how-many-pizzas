/* global jQuery */
(function ($) {
    'use strict';

    var pizzaSizes = [
        {label: 'Small', diameter: 10, slices: 6},
        {label: 'Medium', diameter: 12, slices: 6},
        {label: 'Large', diameter: 14, slices: 8},
        {label: 'XLarge', diameter: 16, slices: 10}
    ];

    function slicesPerPerson(size, slices) {
        var area = Math.pow(size / 2, 2) * 3.14159,
            perSlice = area / slices,
            standardSlice = Math.pow(14 / 2, 2) * 3.14159 / 8,
            ratio = perSlice / standardSlice;
        return 3 / ratio;
    }

    function peopleToPizzas(people, size, slices) {
        var totalSlices = slicesPerPerson(size, slices) * people;
        return Math.ceil(totalSlices / slices);
    }

    function pluralize(count) {
        return count === 1 ?  '' : 's';
    }

    $('#people').on('change blur', function (e) {
        var people = parseInt($(this).val(), 10),
            answer = $('#pizza-answer');
        $('.pizza', answer).remove();
        if (isNaN(people)) {
            answer.hide();
        } else {
            $.each(pizzaSizes, function (i, pizza) {
                var container =  $('<div>').addClass('pizza size-' + pizza.diameter),
                    result = $('<div>').addClass('result'),
                    spacer = $('<div>').addClass('spacer').text('or'),
                    count = peopleToPizzas(people, pizza.diameter, 10, pizza.slices);
                result.text(count + ' '  + pizza.label + pluralize(count) + ' (' + pizza.diameter + '")');
                if (i > 0 ) {
                    container.append(spacer);
                }
                container.append(result);
                answer.append(container);
            });
            answer.show();
        }
    });

})(jQuery);
