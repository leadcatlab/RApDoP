# RApDoP: Repulsively Approaching p-Dispersion on Polygons

### Authors: Zhengguan Dai (Gary), Kathleen Xu, Melkior Ornik

## Environment Requirements
MATLAB2018b or later; use of MATLAB Parallel Computing Toolbox will save time.

## Overview
The p-dispersion problem seeks to place a fixed number of equally sized non-overlapping circles of maximal possible radius into a subset of the two-dimensional plane. This code is the implementation of a repulsion-based p-dispersion algorithm, also able to handle hard bounds on distances between particular circles. 
## Functionality
Given a convex or non-convex simple polygon, number of circles p, and distance bounds on circle centers, the code will produce a suboptimal solution to the p-dispersal problem, where all circles are entirely within the polygon and given constraints are satisfied.
## Instructions
After downloading the code, run RApDop.m. You will be prompted to configure your dispersion problem: please the number of circles, the number of random initial sets of circle centers you would like to attempt, and the vertices of the polygon. If you previously ran the tool, you will have the option to rerun the previous configuration without making new inputs. You will also be able to place hard bounds on circle distances.

After completing the algorithm, the x and y coordinates of the best circle centers will be given in max.xc and max.yc variables of max.mat. A figure will show the best dispersion found, and the resulting radius will be printed in the command line and on the figure.

## Acknowledgment
Utility function /util/lineSegmentIntersect.m which calculates line-segments intersections was adapted from U. Murat Erdem's code published at MathWorks File Exchange: https://www.mathworks.com/matlabcentral/fileexchange/27205-fast-line-segment-intersection. All other files in this directory were created by the authors.
