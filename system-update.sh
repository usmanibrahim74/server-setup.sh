# ====================== SYSTEM UPDATE & CLEANUP ======================
   echo "Updating system and removing unnecessary packages..."
  apt update
  apt purge -y apache2*
  apt autoremove -y --purge
