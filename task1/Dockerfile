# Use the R base image as the base
FROM r-base

# Update the package lists and install Python 2 and python3 
RUN apt-get update && apt-get install -y python2.7 python3.8 

RUN R -e "install.packages('litter')"
COPY helloworld.r .
EXPOSE 80
ENTRYPOINT ["Rscript" , "helloworld.r"]
CMD ["$1"] 
