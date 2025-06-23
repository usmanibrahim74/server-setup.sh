# ====================== SYSTEM UPDATE & CLEANUP ======================
   echo "Updating system and removing unnecessary packages..."
  apt-get update -qq
  apt-get purge -y apache2* snapd
  apt-get autoremove -y --purge
  apt-get upgrade -y
