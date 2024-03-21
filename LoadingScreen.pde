class LoadingClass
{
  PImage[] loadingGif;
  int frameAmount = 64;
  int currentFrame = 0;
  
  LoadingClass(PImage[] externalLoadingGif)
  {
    externalLoadingGif = loadingGif;
  }
  
  // 
  void draw() 
  {
    background(255);
    currentFrame = (currentFrame+1) % frameAmount;
    image(loadingGif[currentFrame] , ((1920/2) - 170), ((1080/2) - 168));
    tint(255, 128);
    
  } 
}
