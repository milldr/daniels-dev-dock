$DIR=$Env:DEV
$Service = Test-Path $DIR/development_backup
if (-Not $Service) {New-Item -Path "$DIR" -Name "development_backup" -ItemType "directory"}
docker build -t milldr/base:latest ./images/base
docker build -t milldr/complete-devops-toolset:latest ./images/complete-devops-toolset
docker run -it --rm `
  -v $DIR/.ssh/:/home/developer/.ssh/ `
  -v $DIR/.aws/:/home/developer/.aws/ `
  -v $DIR/development_backup:/home/developer/shared `
  milldr/complete-devops-toolset zsh
