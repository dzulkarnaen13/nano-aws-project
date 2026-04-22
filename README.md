cat << 'EOF' > README.md
# 🚀 S3 Static Website Deployment using AWS CLI

---

## 🎯 OBJECTIVE

Project ini simulate real workflow guna:
- Bash (Linux terminal)
- AWS CLI
- S3 (static website)

Goal:
✔ Create file  
✔ Upload ke AWS  
✔ Publish website  
✔ Test (HTTP)  
✔ Cleanup  

## 🔥 Why this project

This project demonstrates:
- real AWS CLI workflow
- S3 static hosting
- debugging cloud errors

👉 Website boleh access = SUCCESS ✅

---

## 🧠 FULL FLOW

CREATE → VERIFY → CREATE BUCKET → UPLOAD → VERIFY → CONFIG → TEST → DELETE

---

# 🟢 PHASE 1 — CREATE (LOCAL)

## STEP 1 — Create Project Folder

cd ~  
mkdir nano1-test && cd nano1-test  

Type:
- cd, mkdir → ✅ WAJIB HAFAL  
- nano1-test → 🟡 CUSTOM  

---

## STEP 2 — Create File

nano index.html  

Example:
<h1>Hello AWS</h1>  
<p>nano daily practice</p>  

Type:
- nano → ✅ WAJIB HAFAL  
- index.html → 🟡 CUSTOM  

---

# 🔵 PHASE 2 — VERIFY

## STEP 3 — Check File

ls  
cat index.html  

Type:
- ls, cat → ✅ WAJIB HAFAL  

---

# 🟣 PHASE 3 — BUCKET

## STEP 4 — Generate Bucket Name

TS=$(date +%s)  
BUCKET=nano1-test-$TS  
echo $BUCKET  

Type:
- $(date +%s) → ✅ WAJIB HAFAL  
- variable → ✅ WAJIB FAHAM  

---

## STEP 5 — Create Bucket

aws s3 mb s3://$BUCKET --region ap-southeast-1  

Type:
- aws s3 mb → ✅ WAJIB HAFAL  

---

# 🟡 PHASE 4 — UPLOAD

## STEP 6 — Upload File

aws s3 cp index.html s3://$BUCKET/  

Type:
- aws s3 cp → ✅ WAJIB HAFAL  

---

# 🔵 PHASE 5 — VERIFY UPLOAD

## STEP 7 — Check S3

aws s3 ls s3://$BUCKET/  

Type:
- aws s3 ls → ✅ WAJIB HAFAL  

---

# 🟠 PHASE 6 — CONFIG WEBSITE

## STEP 8 — Enable Website

aws s3 website s3://$BUCKET/ --index-document index.html  

---

## STEP 9 — Disable Block Public Access

aws s3api put-public-access-block \
--bucket $BUCKET \
--public-access-block-configuration '{
  "BlockPublicAcls": false,
  "IgnorePublicAcls": false,
  "BlockPublicPolicy": false,
  "RestrictPublicBuckets": false
}'

Type:
- JSON → 📋 COPY PASTE  

---

## STEP 10 — Apply Policy

aws s3api put-bucket-policy --bucket $BUCKET --policy '{
  "Version":"2012-10-17",
  "Statement":[{
    "Effect":"Allow",
    "Principal": "*",
    "Action":["s3:GetObject"],
    "Resource":["arn:aws:s3:::'"$BUCKET"'/*"]
  }]
}'

Type:
- JSON → 📋 COPY PASTE  

---

# 🟢 PHASE 7 — TEST

## STEP 11 — Test Website

URL="http://$BUCKET.s3-website-ap-southeast-1.amazonaws.com"  
echo $URL  

curl $URL  
curl -I $URL  

Expected:
- HTML output  
- HTTP 200 OK  

---

# 🔴 PHASE 8 — DELETE

## STEP 12 — Cleanup

aws s3 rm s3://$BUCKET --recursive  
aws s3 rb s3://$BUCKET  

cd ~  
rm -rf nano1-test  

---

# ❌ COMMON ERROR

1. Bucket name salah  
Fix: gunakan timestamp  

2. Access Denied  
Fix: disable block public access  

3. Stuck ">"  
Fix: CTRL + C  

---

# 🧠 BASH GUIDE

## WAJIB HAFAL
cd, mkdir, ls, cat, nano  
$(date +%s), $VAR  
aws s3 mb, cp, ls  
curl  

## FAHAM
aws s3api structure  

## COPY PASTE
JSON policy  

## CUSTOM
folder name  
file name  
bucket name  

---

# ✅ SUCCESS CHECK

✔ Bucket created  
✔ File uploaded  
✔ Website accessible  
✔ HTTP 200 OK  
✔ Cleanup done  

---

# 🚀 NOTE

nano = training sahaja  
real project guna VSCode / CI-CD  
flow tetap sama  
EOF
