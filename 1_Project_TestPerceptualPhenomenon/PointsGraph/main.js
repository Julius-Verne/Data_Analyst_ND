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
      points();



    };


var pointConverter = function(d) {
return {
  congruent: parseFloat(d.Congruent),
  incongruent: parseFloat(d.Incongruent)
  };
}

var points = function () {
  d3.csv('assets/stroopdata.csv', pointConverter, function(data) {

      dataset = data;
      dataset_size = dataset.length;
      console.log( dataset);

      var scaleY = d3.scaleLinear()
      .range([height , 0 + margin.top])
      .domain([
            d3.min(dataset, function (d) { return d.congruent; }),
            d3.max(dataset, function (d) { return d.incongruent + 5; })

          ]);

      var scaleX = d3.scaleLinear()
      .range([margin.left + 20 ,width])
      .domain([0, dataset_size]);



      var yAxis = d3.axisLeft()
							  .scale(scaleY)
							  .ticks(4);

      lines = svg.selectAll("line");

      lines.data(dataset)
      .enter()
      .append('line')
          .style('stroke', '#8f91a2')
          .style('stroke-width', '1px')
          .attr('y1', function (d) {
          return scaleY(d.congruent);
          })
          .attr('x1', function (d,i) {
          return scaleX(i);
          })
          .attr('y2', function (d) {
          return scaleY(d.incongruent);
          })
          .attr('x2', function (d,i) {
          return scaleX(i);
          });

          svg.append('line')
              .style('stroke', '#F00')
              .style('stroke-width', '1px')
              .attr('y1', scaleY(mean_congruent))
              .attr('x1', margin.left)
              .attr('y2', scaleY(mean_congruent))
              .attr('x2', width);

          svg.append('text')
              .text(function (d) {
                  return "Congruent Mean: \n"+ mean_congruent;
              })
              .attr('y', scaleY(mean_congruent) + 20 )
              .attr('x',  width-margin.bottom - 80)
              .attr("font-family", "sans-serif")
         	   .attr("font-size", "10px")
         	   .attr("fill", "red");

             svg.append('line')
                 .style('stroke', '#F00')
                 .style('stroke-width', '1px')
                 .attr('y1', scaleY(mean_incongruent))
                 .attr('x1', margin.left)
                 .attr('y2', scaleY(mean_incongruent))
                 .attr('x2', width);

             svg.append('text')
                 .text(function (d) {
                     return "Incongruent Mean: \n"+ mean_incongruent;
                 })
                 .attr('y', scaleY(mean_incongruent) - 10 )
                 .attr('x',  width-margin.bottom - 80)
                 .attr("font-family", "sans-serif")
                .attr("font-size", "10px")
                .attr("fill", "red");


      circles = svg.selectAll("circle");

        circles.data(dataset)
        .enter()
        .append("circle")
        .attr("cx", function (d, i) {
          return scaleX(i);
        })
        .attr("cy", function (d) {
          return scaleY(d.congruent);
        })
        .attr("r", 4)
        .attr("class", "congruent")
        .append("title")
                .text(function(d) { return "Congruent" + "\n" + (d.congruent); })
                .attr("class", "overlay");

        circles.data(dataset)
        .enter()
        .append("circle")
        .attr("cx", function (d, i) {
          return scaleX(i);
        })
        .attr("cy", function (d) {
          return scaleY(d.incongruent);
        })
        .attr("r", 4)
        .attr("class", "incongruent")
         .append("title")
          .text(function(d) { return "Incongruent" + "\n" + (d.incongruent); })
            .attr("class", "overlay");


        //Create Y axis
        svg.append("g")
          .attr("class", "axis")
          .attr("transform", "translate(" + margin.left + ",0)")
          .call(yAxis);




  })
}


d3.select(".next_b")
  .on("click", function() {
    wait(2000);
points();
});
