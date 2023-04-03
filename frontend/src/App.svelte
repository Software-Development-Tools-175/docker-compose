<script>
  let img, fileInput, firstName, lastName, arrNumber, fileOutput;

  const onFileSelected = (e) => {
    let image = e.target.files[0];
    let reader = new FileReader();
    reader.readAsDataURL(image);
    reader.onload = (e) => {
      img = e.target.result;
    };
  };

  async function getImg() {
    if (img === null) {
      alert("Please select an image file first.");
      return;
    }

    let formData = {
      image: img,
      name: firstName,
      surname: lastName,
      numbers: arrNumber,
    };

    let request = await fetch("http://54.82.234.201:8088/process-image", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(formData),
    });

    const response = await request.json();
    fileOutput = response.processed_image;
  }
</script>

<main>
  <div class="w-full h-screen flex justify-center items-center">
    <div
      class="w-full h-screen bg-gray-200 flex flex-col justify-center items-center space-y-6 "
    >
      <div class="bg-gray-500 w-2/5 rounded-lg">
        <div class="p-8 flex flex-col space-y-4">
          <input
            type="text"
            class="px-4 py-2 rounded-md border border-[#c4c4c4] bg-gray-200 text-gray-800"
            placeholder="Name"
            bind:value={firstName}
          />
          <input
            type="text"
            class="px-4 py-2 rounded-md border border-[#c4c4c4] bg-gray-200 text-gray-800"
            placeholder="Surname"
            bind:value={lastName}
          />
          <input
            type="text"
            class="px-4 py-2 rounded-md border border-[#c4c4c4] bg-gray-200 text-gray-800"
            placeholder="[1, 2 3, 4]"
            bind:value={arrNumber}
          />
          <input
            type="file"
            accept=".jpg, .jpeg, .png"
            on:change={(e) => onFileSelected(e)}
            bind:this={fileInput}
          />
          <button
            on:click={() => getImg()}
            class="bg-gray-800 text-white py-2 px-10 rounded-md"
            >Get Image</button
          >
        </div>
      </div>

      <div class="flex">
        <img width="500px" height="500px" src={img} alt="" class="rounded-md" />
        <img
          width="500px"
          height="500px"
          src={fileOutput}
          alt=""
          class="rounded-md"
        />
      </div>
    </div>
  </div>
</main>
