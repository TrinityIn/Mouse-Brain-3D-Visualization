import Banner from "./components/Banner";
import Image from "next/image";


export default function Home() {
  return (
      
      <div>
        <Banner />
        <div id="hero" class=" border-b-2 h-auto gap-6 py-4 flex justify-center flex-row px-40 bg-slate-500">
          <div id="image" class=" bg-slate-700 border-2 border-slate-100  hover:shadow-lg hover:shadow-slate-300 rounded-full">
            <Image
              src="/graphic1.png"
              width={500}
              height={400}
              alt="transparent img"
            />

          </div>

          <div id="text" class="bg-slate-100 w-2/3 text-right py-4 pr-8 rounded-xl">
            <h2 class="text-4xl border-1">Overview</h2>

            <div class=" text-left text-3xl px-8 border-t-2 border-slate-400 py-10">

              <h3 class="mr-0 pt-2">What ?</h3>
              <p class="text-xl font-mono pb-2">We created <span class="font-semibold">Brain Voyager</span>, a way to view data visualizations in a 3D space.</p>
              <h3>Why ?</h3>
              <p class="text-xl font-mono pb-2">To encourage data literacy by providing an engaging medium to view and understand important data.</p>
            </div>
            
          </div>
          
        </div>

        <div id="dataset">
          <h2 class="text-3xl p-8">Context on dataset</h2>


        </div>

      </div>
  );
}