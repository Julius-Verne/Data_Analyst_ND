//Create Variables
var dataset;
var xScale, yScale;
var xAxis, yAxis;

// Create rowConverter to adapt the dataset to our needs
  var rowConverter = function(d) {
  return {
    congruent: parseFloat(d.congruent),
    incongruent: parseFloat(d.incongruent)
    };
  }

var margin = {top: 20, right: 10, bottom: 20, left: 10},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

    //Load CSV
d3.csv('assets/stroopdata.csv', rowConverter, function(data) {

  dataset = data;

    var svg = d3.select('body').append('svg')
    .attr('width', width + margin.left + margin.right)
    .attr('height', height + margin.top + margin.bottom)
  .append('g')
    .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

var formatValue = d3.format(",d");

var scale = d3.scaleLinear()
    .domain([
      d3.min(dataset, function (d){
         return d.congruent;
      }), d3.max(dataset, function (d) {
        return d.incongruent;
      })])
    .range([0, width]);

    /*var x = d3.scaleLog()
        .rangeRound([0, width]);*/

      //  x.domain(d3.extent(data, function(d) { return d.value; }));
var g = svg.append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var simulation = d3.forceSimulation(data)
    .force("x", d3.forceX(function(d) { return scale(d.value); }).strength(1))
    .force("y", d3.forceY(height / 2))
    .force("collide", d3.forceCollide(4))
    .stop();

for (var i = 0; i < 120; ++i) simulation.tick();

g.append("g")
    .attr("class", "axis axis--x")
    .attr("transform", "translate(0," + height + ")")
    .call(d3.axisBottom(scale).ticks(20, ".0s"));

var cell = g.append("g")
    .attr("class", "cells")
  .selectAll("g").data(d3.voronoi()
      .extent([[-margin.left, -margin.top], [width + margin.right, height + margin.top]])
      .x(function(d) { return d.x; })
      .y(function(d) { return d.y; })
    .polygons(data)).enter().append("g");

cell.append("circle")
    .attr("r", 3)
    .attr("cx", function(d) { return d.data.x; })
    .attr("cy", function(d) { return d.data.y; });

cell.append("path")
    .attr("d", function(d) { return "M" + d.join("L") + "Z"; });

cell.append("title")
    .text(function(d) { return d.data.id + "\n" + formatValue(d.data.value); });
});

function type(d) {
if (!d.value) return;
d.value = +d.value;
return d;
}
