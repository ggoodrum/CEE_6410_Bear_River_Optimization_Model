# Optimizing-Stream-Barrier-Removal____GG Bear River Adaptation Notes

# Date: 12/8/2020

# Description:
# This README contains information for how to adapt the Kraft et al. 2019 
# Optimizing Stream Barrier Removal model for another river basin.

# Input data:
# Geospatial: Contacted author, but no clear workflow for how to produce model inputs from geospatial data.
# Tables - INPUT: Hand-create from stream network. NOTE: INPUT$links appears to start from Node 560, but actually matches
#                 the distance table and starts from Node 559. Dimensions should match the distance table.

# GAMS code:
# SETS j,k: These should be changed to a numeric list of Nodes in descending order. Here /560,...550/
# Call INPUT_PATH_UP: rng = Sheet1!, not path_up!. par=path_up, not Sheet1.
# Call INPUT: all 'rng=' need to be bounded to the appropriate topleft:bottom right cell numbers in excel spreadsheets.
#             For example, rng=distance!A1:MK349 becomes rng=distance!A1:L12 in this example.

