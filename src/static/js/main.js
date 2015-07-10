/* global jQuery */
(function ($) {
    'use strict';

    var pizzaSizes = {
        // Diameter --> # of slices
        10: 6,
        12: 8,
        14: 8,
        16: 10
    };

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
        $.each(pizzaSizes, function (diameter, slices) {
            var container =  $('<div>').addClass('pizza size-' + diameter),
                result = $('<span>').addClass('result'),
                count = peopleToPizzas(people, parseInt(diameter, 10), slices);
            result.text(count + ' '  + diameter + '" pizza' + pluralize(count));
            container.append(result);
            answer.append(container);
        });
        answer.show();
    });

})(jQuery);
