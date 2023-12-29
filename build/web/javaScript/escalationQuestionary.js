/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$('[name="escalation"]').change(function () {
                                                                                                                                if ($(this).is(':checked')) {
                                                                                                                                    $(".esclQues").dialog({
                                                                                                                                        title: "Checklist of Escalation admin/update",
                                                                                                                                        draggable: true,
                                                                                                                                        modal: true,
                                                                                                                                        width: 700,
                                                                                                                                        maxHeight: 700,
                                                                                                                                        position: {my: "center",
                                                                                                                                            at: "top",
                                                                                                                                            of: window,
                                                                                                                                            collision: "fit",
                                                                                                                                            // Ensure the titlebar is always visible
                                                                                                                                            using: function (pos) {
                                                                                                                                                var topOffset = $(this).css(pos).offset().top;
                                                                                                                                                if (topOffset < 0) {
                                                                                                                                                    $(this).css("top", pos.top - topOffset);
                                                                                                                                                }
                                                                                                                                            }
                                                                                                                                        },
                                                                                                                                        resizable: false,
                                                                                                                                        show: {
                                                                                                                                            effect: "blind",
                                                                                                                                            duration: 1000
                                                                                                                                        },
                                                                                                                                        hide: {
                                                                                                                                            effect: "blind",
                                                                                                                                            duration: 1000
                                                                                                                                        },
                                                                                                                                        open: function () {
                                                                                                                                            $("body").css("overflow", "hidden");
                                                                                                                                        },
                                                                                                                                        close: function () {
                                                                                                                                            $("body").css("overflow", "auto");
                                                                                                                                        }

                                                                                                                                    });
                                                                                                                                    $(".esclQues > img").show();
                                                                                                                                    $(".esclQues > div").html("");
                                                                                                                                    $(".esclQues").dialog("open");

                                                                                                                                    $.ajax({url: '<%=request.getContextPath()%>/escalationQustions.jsp',
                                                                                                                                        data: {random: Math.random(1, 10)},
                                                                                                                                        async: true,
                                                                                                                                        type: 'GET',
                                                                                                                                        success: function (responseText, statusTxt, xhr) {
                                                                                                                                            if (statusTxt === "success") {
                                                                                                                                                var result = $.trim(responseText);
                                                                                                                                                $(".esclQues > div").html(result);

                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                    });
                                                                                                                                } else {
                                                                                                                                    $(".esclQues").hide();
                                                                                                                                }
                                                                                                                            });