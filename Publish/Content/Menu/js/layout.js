$(function () {

    var $wndw = $(window),
        $html = $('html'),
        $body = $('body'),
        $both = $('body, html');


    String.prototype.capitalize = function () {
        return this.charAt(0).toUpperCase() + this.slice(1);
    }

    setTimeout(function () {
        $body.addClass('docready');
    }, 250);


    //	Auto submenu
    var sections = [];
    var submenu = '';
    $('.submenutext')
        .each(
        function (i) {
            var $h = $(this).parent(),
                id = $h.attr('id') || 'h' + i;

            $h.attr('id', id);

            sections.push('#' + id);
            submenu += '<li><a href="#' + id + '">' + $(this).text().capitalize() + '</a></li>';
        }
        );

    if (submenu.length) {
        sections = sections.reverse();

        var $h1 = $('h1').first().addClass('has-submenu');

        var $submenu = $('<div class="submenu"><div><ul>' + submenu + '</ul></div></div>')
            .insertAfter($h1);

        var fixed = false,
            start = $submenu.offset().top;

        $submenu
            .find('a')
            .each(
            function () {
                var href = $(this).attr('href');
                $body
                    .find('a[href="' + href + '"]')
                    .on('click',
                    function (e) {
                        e.preventDefault();
                        $both.animate({
                            scrollTop: $(href).offset().top - 120
                        });
                    }
                    );
            }
            );



        var _selected = -1;
        var $subitems = $submenu
            .find('li');

        $wndw
            .on('scroll.submenu',
            function (e) {
                var offset = $wndw.scrollTop();
                for (var s = 0; s < sections.length; s++) {
                    if ($(sections[s]).offset().top < offset + 160) {
                        if (_selected !== s) {
                            _selected = s;
                            $subitems
                                .removeClass('selected')
                                .find('[href="' + sections[s] + '"]')
                                .parent()
                                .addClass('selected');
                        }
                        break;
                    }
                }
            }
            );

        $wndw
            .trigger('scroll.submenu');
    }



    //	The menu
    if ($.fn.mmenu) {

        var API = $('#menu')
            .mmenu({
                extensions: ['fx-menu-slide', 'shadow-page', 'shadow-panels', 'listview-large', 'pagedim-black'],
                iconPanels: true,
                counters: true,
                keyboardNavigation: {
                    enable: true,
                    enhance: true
                },
                searchfield: {
                    placeholder: 'Search BMS 17'
                },
                navbar: {
                    title: 'Home'
                },
                navbars: [
                    {
                        position: 'top',
                        content: ['searchfield']
                    }, {
                        position: 'top',
                        content: ['breadcrumbs', 'close']
                    }, {
                        position: 'bottom',
                        content: [
                            '<a href="mailto:bms17@gmail.com" target="_blank"><i class="fa fa-envelope"></i> Contact Us</a>',
                            '<a href="mailto:bms17@gmail.com" target="_blank"><i class="fa fa-phone"></i> (+94)716 271 610</a>'
                        ]
                    }
                ]
            },
            {
                searchfield: {
                    clear: true
                }
            })
            .data('mmenu');

        var $burger = $('#hamburger')
            .on('click',
            function (e) {
                e.preventDefault();
                if ($html.hasClass('mm-opened')) {
                    API.close();
                    $("#hamburger").css({ "width": "4%", "top": "0px" });
                    //$(".navbar-fixed-top").css({ "position": "fixed" });
                    //$('.mm-slideout').css('position', 'relative');
                    //$('.mm-slideout').css('left', '0');
                }
                else {
                    $("#hamburger").css({ "width": "100%", "top": "2px" });
                    //$(".navbar-fixed-top").css({ "position": "absolute" });
                    API.open();
                }
            }
            )
            .children('.hamburger');

        API.bind('closed', function () {
            setTimeout(function () {
                $burger.removeClass('is-active');
                $("#hamburger").css({ "width": "4%", "top": "0px" });
                //$(".navbar-fixed-top").css({ "position": "fixed" });
            }, 100);
        });
        API.bind('opened', function () {
            setTimeout(function () {
                $burger.addClass('is-active');
                //$('.mm-slideout').css('position', 'absolute');
                //$('.mm-slideout').css('left', '-440px');
            }, 100);
        });
    }



    //	rotate ipad
    $('a.rotate')
        .on('click',
        function (e) {
            e.preventDefault();
            $(this).parent().toggleClass('portrait');
        }
        );


    //	Download animation
    (function () {
        var $row = $('.download-button');
        $row.find('a').on('click.dl',
            function (e) {
                e.preventDefault();
                $row.addClass('downloading');

                var form = $(this).attr('data-form'),
                    href = $(this).attr('href');

                if (form) {
                    document[form].submit();
                }
                else {
                    window.location.href = href;
                }

                setTimeout(function () {
                    window.location.href = window.location.href;
                }, 3000);
            }
        );
    })();


    //	Compose email link, please stop sending me spam...
    setTimeout(function () {
        var b = 'frebsite' + '.' + 'nl',
            o = 'info',
            t = 'mail' + 'to';

        $('#emaillink').attr('href', t + ':' + o + '@' + b);
    }, 2000);



    //	Open menu in examples
    var $phones = $('.phone, .tablets');
    if ($phones.length) {
        var offsets = {};

        $phones
            .each(
            function () {
                var offset = $(this).offset().top - 150;
                if (offset < 0) {
                    offset = 0;
                }

                if (!offsets[offset]) {
                    offsets[offset] = $();
                }
                offsets[offset] = offsets[offset].add(this);
            }
            );

        $wndw
            .on('scroll.phones',
            function () {
                var offset = $wndw.scrollTop();
                for (var o in offsets) {
                    if (offset > o) {
                        offsets[o]
                            .each(
                            function (i) {
                                var iframe = $(this).find('iframe'),
                                    countr = 0;

                                if (!iframe.length) {
                                    return;
                                }

                                iframe = iframe[0].contentWindow;
                                var interv = setInterval(
                                    function () {
                                        if (iframe.$) {
                                            var API = iframe.$('#menu').data('mmenu');
                                            if (API) {
                                                if (API.open) {
                                                    API.open();
                                                }
                                                clearInterval(interv);
                                            }
                                        }

                                        countr++;
                                        if (countr > 50) {
                                            clearInterval(interv);
                                        }
                                    }, 250 + (i * 250)
                                );
                            }
                            );

                        delete offsets[o];
                    }
                }

                for (var v in offsets) {
                    return;
                }
                $(this).off('scroll.phones');
            }
            );

        setTimeout(
            function () {
                $wndw.trigger('scroll.phones');
            }, 2500
        );
    }

});