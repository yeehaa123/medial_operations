$ ->
  h = 600
  w = $("#bar").width()
  barPadding = 3
  
  window.dataurl = $('#bar').data('url')
  window.dataset = $('#bar').data('tagsarray') 

  svg = d3.select("#bar")
          .append("svg")
          .attr("width": w)
          .attr("height": h)
  
  x = d3.scale.linear()
    .domain([0, d3.max(window.dataset, (d) -> d.count)])
    .range([0, w])

  svg.selectAll("rect")
     .data(window.dataset)
     .enter()
     .append("a")
      .attr("xlink:href", (d)->
        url = window.dataurl + "/" + d.name)
      .append("rect")
        .attr("x", 0)
        .attr("fill", "#b58900")
        .attr("y", (d, i) -> i * (20 + barPadding))
        .attr("height", 20)
        .attr("width", (d) -> x(d.count))
  
  svg.selectAll("text")
     .data(dataset)
     .enter()
     .append("text")
     .text((d) -> d.name + " – " + d.count)
     .attr("fill", "#ffffff")
     .attr("font-family", "sans-serif")
     .attr("font-size", "9px")
     .attr("x", 10)
     .attr("y", (d, i) -> (i * (20 + barPadding)) + 13)
