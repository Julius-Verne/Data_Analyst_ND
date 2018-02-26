//Create Variables
var dataset;
var xScale, yScale;
var xAxis, yAxis;

var mean_congruent = 14.05;
var mean_incongruent = 22.01;

// Create rowConverter to adapt the dataset to our needs
  var beeConverter = function(d) {
  return {
    value: parseFloat(d.Value),
    type: d.Type
    };
  }


var svg = d3.select(".viz"),
    margin = {top: 40, right: 40, bottom: 40, left: 40},
    width = svg.attr("width") - margin.left - margin.right,
    height = svg.attr("height") - margin.top - margin.bottom;


  window.onload = function() {
      beeswarm();
    };


var beeswarm = function () {
  d3.csv('assets/stroopdata_clean.csv', beeConverter, function(data) {

    dataset = data;

    var formatValue = d3.format(",d");

    var x = d3.scaleLog()
      .rangeRound([0, width]);

   var line = d3.scaleLinear()
      .range([0,width])
      .domain(d3.extent(dataset, function(d) { return d.value ; }));

      // Define the div for the tooltip
    var div = d3.select("body").append("div")
        .attr("class", "tooltip")
        .style("opacity", 0);

    var g = svg.append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    x.domain(d3.extent(dataset, function(d) { return d.value; }));


    svg.append('line')
        .style('stroke', '#F00')
        .style('stroke-width', '1px')
        .attr('y1', margin.bottom +60 )
        .attr('x1', line(mean_congruent)+40)
        .attr('y2', height - margin.top)
        .attr('x2', line(mean_congruent)+40);

        svg.append('text')
            .text(function (d) {
                return "Congruent Mean: \n"+ mean_congruent;
            })
            .attr('y',  margin.bottom + 40)
            .attr('x', line(mean_congruent)-20)
            .attr("font-family", "sans-serif")
   			   .attr("font-size", "11px")
   			   .attr("fill", "red");


    svg.append('line')
        .style('stroke', '#F00')
        .style('stroke-width', '1px')
        .attr('y1', margin.bottom + 60)
        .attr('x1', line(mean_incongruent)+40)
        .attr('y2', height - margin.top)
        .attr('x2', line(mean_incongruent)+40);

    svg.append('text')
        .text(function (d) {
            return "Incongruent Mean: \n"+ mean_incongruent;
        })
        .attr('y',  margin.bottom + 40)
        .attr('x', line(mean_incongruent)-20)
        .attr("font-family", "sans-serif")
   	   .attr("font-size", "11px")
   	   .attr("fill", "red");


    var simulation = d3.forceSimulation(dataset)
        .force("x", d3.forceX(function(d) { return line(d.value); }).strength(1))
        .force("y", d3.forceY(height / 2))
        .force("collide", d3.forceCollide(5))
        .stop();


        for (var i = 0; i < 120; ++i) simulation.tick();

        g.append("g")
            .attr("class", "axis axis--x")
            .attr("transform", "translate(0," + height + ")")
            .call(d3.axisBottom(line).ticks(8));


        var cell = g.append("g")
            .attr("class", "cells")
          .selectAll("g").data(d3.voronoi()
              .extent([[-margin.left, -margin.top], [width + margin.right, height + margin.top]])
              .x(function(d) {
              //  console.log(d);
                return d.x; })
              .y(function(d) { return d.y; })
            .polygons(dataset)).enter().append("g");

        cell.append("circle")
            .attr("r", 3)
            .attr("cx", function(d) {

               return d.data.x; })
            .attr("cy", function(d) { return d.data.y; })
            .attr("fill", function (d){
              if (d.data.type=="Congruent") {
                return "#2541b2";
              }
              if (d.data.type=="Incongruent") {
                return "#d84727";
              }
            });



        cell.append("path")
            .attr("d", function(d) { return "M" + d.join("L") + "Z"; });

    cell.append("title")
            .text(function(d) { return d.data.type + "\n" + (d.data.value); })
            .attr("class", "overlay");
      });

}
