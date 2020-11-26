if(!require(igraph)) install.packages("igraph")
if(!require(dplyr)) install.packages("dplyr")


read.file.as.list <- function(file.to.read, sep="\t"){
    dat <- readLines(file.to.read)
    dat <- strsplit(dat, sep)

    return(dat)
}


read.clusters.as.list <- function(clust.file){
    ## Read clusters with customised reader:
    clust.list <- read.file.as.list(clust.file)

    ## Drop first two columns that denote cluster index and 1.0 (just to separate index from members):
    clust.list <- lapply(clust.list, function(x) x[c(-1, -2)])

    return(clust.list)
}

## --------------------------------------------------------------

netF <- "./data/network.tab"
clustsF <- "./data/network.tab"

## Read network:
net <- read.csv(netF, sep="\t", header=F)
net <- net %>% dplyr::rename(from = V1, to = V2, weight = V3)
G <- igraph::graph_from_data_frame(net )

## Read clusters:
clust <- read.clusters.as.list(clustsF)

c1 <- clust[[94]]

ind1 <- igraph::induced.subgraph(G, vids = V(G)[c1])

igraph::plot.igraph(ind1)



