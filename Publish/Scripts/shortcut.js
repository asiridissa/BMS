shortcut = {
    keys: new Object(),
    add: function (array, func) {
        var hey = this;
        var counter = this.stingify(array);
        this.keys[counter] = func;
        var collect = new Array();
        document.body.addEventListener('keydown', function (e) {
            if (e.keyCode === array[collect.length]) {
                collect[collect.length] = e.keyCode;
            } else {
                collect = new Array();
            }
            if (collect.length === array.length) {
                e.stopPropagation();
                collect = new Array();
                hey.keys[counter]();
            }
        }, false);

    },
    remove: function (array) {
        this.keys[this.stingify(array)] = function () {

        };
    },
    stingify: function (array) {
        var counter = '';
        for (x in array) {
            if (x == 0) {
                counter += array[x];
            } else {
                counter += '+' + array[x];
            }
        }
        return counter;
    }
};