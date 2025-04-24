        // Initialize collapsible (accordion)
        document.addEventListener('DOMContentLoaded', function() {
          var elems = document.querySelectorAll('.collapsible');
          var instances = M.Collapsible.init(elems);
      });

      function betterNumber(x) {
          return x.toLocaleString("fr-FR");
      }

      var lastPoints = 0;
      var lastMulti = "x0.0";

      $(function () {
          window.addEventListener("message", function (event) {
              var item = event.data;

              if (item.ShowHud) {
                  // Drift points
                  $(".driftDisplay").html(betterNumber(item.driftPoints));
                  $(".driftDisplayMulti").html(item.driftDisplayMulti);

                  lastPoints = item.driftPoints;
                  lastMulti = item.driftDisplayMulti;

                  $("#container").fadeIn(500);
              } else if (item.HideHud) {
                  // Hide GUI
                  $(".driftImage").html('<img class="animate__animated animate__hinge driftImage" src="images/drifting.png" />');
                  $(".driftDisplay").html('<div class="animate__animated animate__hinge driftDisplay"><span> ' + lastPoints +'</span></div>');
                  $(".driftDisplayMulti").html('<div class="animate__animated animate__hinge driftDisplayMulti"><span> ' + lastMulti + '</span></div> ');
                  $("#container").fadeOut(1000);
              }

              if (item.ShowSucces) { 
                  $("#containerSucces").fadeIn(100);
                  $(".succesText").html(item.label);
              } else if (item.HideSucces) {
                  $("#containerSucces").fadeOut(500);
              }

              if (item.containerJoins) {
                  $("#containerJoin").fadeIn(0);
              } 

              if (item.joinClick) {
                  $("#containerJoin").fadeOut(500);
              }
          });

          $('.clickJoinButton').on('click', function (e) {
              e.preventDefault();
              $.post('https://driftV/joinServer', JSON.stringify(test = false));
          });

          $(document).ready(function() {
              $(".clickJoinButton").click(function() {
                  // Hide game logo
                  $(".game-logo").fadeOut();
                   $("nav").fadeOut();
                  $("#containerJoin").fadeOut();
                  $(".version").fadeOut(); 
              });

              $(".seasonButton").click(function() {
                  $(".game-logo").addClass("hiddenContent");
                  $("nav").addClass("hiddenContent");
                  $("#containerJoin").addClass("hiddenContent");
                  $("#containerSucces").addClass("hiddenContent");
                  $(".buttonContainer").addClass("hiddenContent");
                  $("#devUpdateModal").fadeIn();
              });

              $(".closeButton").click(function() {
                  $("#devUpdateModal").fadeOut();
                  $(".game-logo").removeClass("hiddenContent");
                  $("nav").removeClass("hiddenContent");
                  $("#containerJoin").removeClass("hiddenContent");
                  $("#containerSucces").removeClass("hiddenContent");
                  $(".buttonContainer").removeClass("hiddenContent");
              });
          });
      });
