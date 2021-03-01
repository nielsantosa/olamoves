import $ from 'jquery';

const videos = document.querySelectorAll('video');


const vidPlay = () => {
  $(document).on('mouseover', 'video', e => {
    e.target.play();
  })

  $(document).on('mouseout', 'video', e => {
    e.target.pause();
  })
  // document.addEventListener('mouseover', e => {
  //   if(e.target.nodeName === 'video') {
  //   }
  // })

  // document.addEventListener('mouseout', e => {
  //   if(e.target.nodeName === 'video') {
  //     e.target.pause();
  //   }
  // })
  // videos.forEach((video) => {
  //   video.addEventListener('mouseover', (e) => {
  //     console.log('hello')
  //     e.currentTarget.play();
  //   });
  //   video.addEventListener('mouseout', (e) => {
  //     e.currentTarget.pause();
  //   });
  // });
};

export default vidPlay;
